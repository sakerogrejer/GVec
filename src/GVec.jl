module GVec
    include("Vectors/Vec2.jl")
    include("Vectors/Vec3.jl")
    include("Vectors/Vec4.jl")
    include("Matrix/Matrix.jl")

    export Vec2, Vec3, Vec4, Mat2, Mat3, Mat4
    export determinant, trace, inverse, to_matrix
    export zero, one, dot, cross, norm, normalize


    # Vector * Matrix
    function Base.:*(v::Vec2, m::Mat2)
        Vec2(
            v.x * m.p00 + v.y * m.p10,
            v.x * m.p01 + v.y * m.p11
        )
    end

    function Base.:*(v::Vec3, m::Mat3)
        Vec3(
            v.x * m.p00 + v.y * m.p10 + v.z * m.p20,
            v.x * m.p01 + v.y * m.p11 + v.z * m.p21,
            v.x * m.p02 + v.y * m.p12 + v.z * m.p22
        )
    end

    function Base.:*(v::Vec4, m::Mat4)
        Vec4(
            v.x * m.p00 + v.y * m.p10 + v.z * m.p20 + v.w * m.p30,
            v.x * m.p01 + v.y * m.p11 + v.z * m.p21 + v.w * m.p31,
            v.x * m.p02 + v.y * m.p12 + v.z * m.p22 + v.w * m.p32,
            v.x * m.p03 + v.y * m.p13 + v.z * m.p23 + v.w * m.p33
        )
    end

    # Matrix * Vector
    function Base.:*(m::Mat2, v::Vec2)
        Vec2(
            m.p00 * v.x + m.p01 * v.y,
            m.p10 * v.x + m.p11 * v.y
        )
    end

    function Base.:*(m::Mat3, v::Vec3)
        Vec3(
            m.p00 * v.x + m.p01 * v.y + m.p02 * v.z,
            m.p10 * v.x + m.p11 * v.y + m.p12 * v.z,
            m.p20 * v.x + m.p21 * v.y + m.p22 * v.z
        )
    end

    function Base.:*(m::Mat4, v::Vec4)
        Vec4(
            m.p00 * v.x + m.p01 * v.y + m.p02 * v.z + m.p03 * v.w,
            m.p10 * v.x + m.p11 * v.y + m.p12 * v.z + m.p13 * v.w,
            m.p20 * v.x + m.p21 * v.y + m.p22 * v.z + m.p23 * v.w,
            m.p30 * v.x + m.p31 * v.y + m.p32 * v.z + m.p33 * v.w
        )
    end

end # module GVec
